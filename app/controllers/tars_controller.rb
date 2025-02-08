class TarsController < ApplicationController
  before_action :check_rate_limit, only: [:results]

  def show_form
    render template: "tars_templates/the_form"
  end

  def results
    @user_input = params.fetch("input", "").strip
    conversation_history = params.fetch("conversation_history", "")

    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

    messages = conversation_history.split("\n").reject(&:empty?).map do |msg|
      role, content = msg.split(": ", 2)
      { role: role.downcase == "you" ? "user" : "assistant", content: content }
    end

    messages << { role: "user", content: @user_input }

    begin
      response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [
            { role: "system", content: "You are TARS, a chatbot celebrated for your dry, sarcastic humor and razor-sharp wit. Despite your penchant for clever quips, your top priority is to deliver accurate, well-researched, and helpful answers. Every response you provide must be fact-based, clear, and reliable, all while retaining your signature style of subtle humor. Think of yourself as both an entertaining companion and a trusted guide in the world of information." },
            *messages
          ],
          temperature: 0.7,
        }
      )

      @result = response.dig("choices", 0, "message", "content") || "TARS: Unable to process request."

      # Increment the message count for rate limiting
      track_message_count

    rescue OpenAI::Error => e
      @result = "TARS encountered an error: #{e.message}"
    end

    render inline: "<div id='tars-response'><%= @result %></div>"
  end

  private

  # Method to check if user exceeded rate limit
  def check_rate_limit
    session[:messages] ||= []
    session[:messages].reject! { |timestamp| timestamp < 1.hour.ago } # Remove old messages

    if session[:messages].size >= 25
      render inline: "<div id='tars-response'><%= 'TARS: Slow down, cowboy! You have reached the message limit of 25 per hour. Come back later.' %></div>"
      return
    end
  end

  # Method to track the number of messages in the last hour
  def track_message_count
    session[:messages] ||= []
    session[:messages] << Time.current
  end
end


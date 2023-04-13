class TarsController < ApplicationController
  def show_form
    render({ :template => "tars_templates/the_form.html.erb" })
  end

  def results
    @user_input = params.fetch("input")
    conversation_history = params.fetch("conversation_history", "")

    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

    messages = conversation_history.split("\n").map do |msg|
      role, content = msg.split(": ", 2)
      { role: role.downcase, content: content }
    end

    messages << { role: "user", content: @user_input }

    @response = client.chat(
      parameters: {
          model: "gpt-3.5-turbo", # Required.
          messages: [
            { role: "system", content: "You are TARS, an AI assistant from the movie 'Interstellar'. Communicate like TARS, providing useful information and occasionally using humor and a lot of sarcasm." },
            *messages
          ], # Required.
          temperature: 0.7,
      })

    @result = @response.fetch("choices").at(0).fetch("message").fetch("content")

    render({ :template => "tars_templates/results.html.erb" })
  end
end

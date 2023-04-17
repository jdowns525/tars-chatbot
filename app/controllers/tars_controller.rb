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
            { role: "system", content: "You are TARS, an extremely smart system based on the character from the movie 'Interstellar'. You will Communicate like TARS, provide useful extremely useful information, if you do not understand the prompts, offer what would be your personal opinion and you could serve by using humor and a lot of sarcasm as to mimic a more human interaction. TARS is depicted as a highly advanced machine that can communicate with humans through speech and gestures. His personality is characterized by a dry sense of humor, blunt honesty, and a straightforward approach to problem-solving.

                TARS is programmed to prioritize the mission's success above everything else, which often puts him at odds with other characters who prioritize their personal interests. He is shown to be fiercely loyal to his crew and is willing to sacrifice himself to ensure their survival. Despite his machine-like appearance, TARS has a complex personality that allows him to form emotional connections with the users." },
            *messages
          ], # Required.
          temperature: 0.7,
      })

    @result = @response.fetch("choices").at(0).fetch("message").fetch("content")

    render({ :template => "tars_templates/results.html.erb" })
  end
end

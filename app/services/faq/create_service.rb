module FaqModule
  class CreateService
    def initialize(params)
      # TODO: identify origin and set company
      @company = Company.last
      @question = params["question.original"]
      @answer = params["answer.original"]
      @hashtags = params["hashtags.original"]
    end

    def call
        #if not have hashtag, hashtag was required
      if @hashtags == nil || @hashtags == ""
        return "Hashtag Obrigatória"
      end

      begin
        Faq.transaction do
          #create a faq with question and answer
          faq = Faq.create(question: @question, answer: @answer, company: @company)
          @hashtags.split(/[\s,]+/).each do |hashtag|
            #get list hashtag
            faq.hashtags << Hashtag.create(name: hashtag)
          end
        end
        "Criado com sucesso"
      rescue
        "Problemas na criação"
      end
    end
  end
end

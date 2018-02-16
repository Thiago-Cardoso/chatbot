require_relative './../../spec_helper.rb'

#tests if created with sucess data and return associateds
describe FaqModule::CreateService do
  before do
    @company = create(:company)

    @question = FFaker::Lorem.sentence
    @answer = FFaker::Lorem.sentence
    @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
  end

  describe '#call' do
    it "Without hashtag params, will receive a error" do
      @createService = FaqModule::CreateService.new({"question.original" => @question, "answer.original" => @answer})

      #create new faq
      response = @createService.call()
      expect(response).to match("Hashtag Obrigatória")
    end

    it "With valid params, receive success message" do
      @createService = FaqModule::CreateService.new({"question.original" => @question, "answer.original" => @answer, "hashtags.original" => @hashtags})

      response = @createService.call()
      expect(response).to match("Criado com sucesso")
    end

    it "With valid params, find question and anwser in database" do
      @createService = FaqModule::CreateService.new({"question.original" => @question, "answer.original" => @answer, "hashtags.original" => @hashtags})

      response = @createService.call()
      #show last data, verificate if question is equal
      expect(Faq.last.question).to eq(@question)
      expect(Faq.last.answer).to eq(@answer)
    end

    it "With valid params, hashtags are created" do
      @createService = FaqModule::CreateService.new({"question.original" => @question, "answer.original" => @answer, "hashtags.original" => @hashtags})
        #call variables @hashtag, get text and separe,(, ) return example ["ruby", "sinatra"]
      response = @createService.call()
      expect(@hashtags.split(/[\s,]+/).first).to eq(Hashtag.first.name)
      expect(@hashtags.split(/[\s,]+/).last).to eq(Hashtag.last.name)
    end
  end
end

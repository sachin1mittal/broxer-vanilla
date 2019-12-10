module ChatsRoutes
  def self.extended(router)
    router.instance_eval do
      # namespace 'api', module: 'api/chats', as: :chats do
      #   namespace :v1 do
      #   end
      # end
      # mount ActionCable.server => '/cable'
    end
  end
end

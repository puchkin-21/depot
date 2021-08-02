class User < ActiveRecord::Base
    has_secure_password
    validates :name, presence: true, uniqueness: true
    after_destroy :ensure_an_admin_remains
    private
        def ensure_an_admin_remains
            if User.count.zero?
                raize "Последний польззователь не может быть удалён"
            end
        end
end
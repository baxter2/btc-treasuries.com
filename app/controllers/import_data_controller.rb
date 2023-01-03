class ImportDataController < ApplicationController
  skip_before_action :verify_authenticity_token

  # https://docs.github.com/en/developers/webhooks-and-events/webhooks/securing-your-webhooks
  def create
    if !verify_webhook(request.headers, request.raw_post)
      render json: {error: "Unauthorized"}, status: :unauthorized
      return
    end

    import_data
  end

private
  def verify_webhook(headers, payload)
    signature = headers["X-Hub-Signature-256"]
    calculated_signature = "sha256=" + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), webhook_secret, payload)
    ActiveSupport::SecurityUtils.secure_compare(signature, calculated_signature)
  end

  def webhook_secret
    Rails.application.credentials.github[:webhook_secret]
  end

  def import_data
    Rake::Task['import:countries'].invoke
    Rake::Task['import:private_companies'].invoke
    Rake::Task['import:public_companies'].invoke
  end
end

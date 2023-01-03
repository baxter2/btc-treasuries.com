class ImportDataController < ApplicationController
  skip_before_action :verify_authenticity_token

  # https://docs.github.com/en/developers/webhooks-and-events/webhooks/securing-your-webhooks
  def create
    if verify_webhook(request.headers, request.raw_post)
      modified_files = request.raw_post["head_commit"]["modified"]

      import_countries if modified_files.include?('countries.json')
      import_private_companies if modified_files.include?('private_companies.json')
      import_public_companies if modified_files.include?('public_companies.json')
    else
      render json: {error: "Unauthorized"}, status: :unauthorized
      render status: :forbidden, json: { error: 'Invalid webhook signature' }
    end

    render json: { success: true }
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

  def import_countries
    ImportDataJob.perform_now("countries.json")
  end

  def import_private_companies
    ImportDataJob.perform_now("private_companies.json")
  end

  def import_public_companies
    ImportDataJob.perform_now("public_companies.json")
  end
end

module Bang
  class ProfileImageUploader
    class << self
      def upload_image_to_s3(image, user_profile_image)
        upload_to_s3(image, user_profile_image, 'normal')
      end

      private
      def bucket
        setting = Settings[:s3][:profile_image]
        credentials = Aws::Credentials.new(ENV['BANG_AWS_ACCESS_KEY'], ENV['BANG_AWS_SECRET_ACCESS_KEY'])
        client = Aws::S3::Client.new(region: setting[:region], credentials: credentials)
        resource = Aws::S3::Resource.new(client: client)
        resource.bucket(setting[:bucket])
      end

      def upload_to_s3(image, user_profile_image, type)
        size = 300
        key = user_profile_image.image_s3_key_name

        data = Magick::Image.from_blob(File.read(image.tempfile.path)).shift
        data.strip!
        data.resize_to_fill!(size, size)

        bucket.put_object(
          key: key,
          acl: 'public-read',
          content_type: 'image/jpeg',
          body: data.to_blob
        )

        data.destroy!
      end
    end
  end
end

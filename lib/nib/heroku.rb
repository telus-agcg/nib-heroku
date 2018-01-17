require 'nib/heroku/version'

module Nib
  module Heroku
    module_function

    def shell(args, env:, size:, type:)
      Nib::Shell.execute(args) if env.to_sym == :dev

      script_parts = [].tap do |parts|
        parts << "heroku run -a #{app(env)}"
        parts << "-s #{size}" if size
        parts << "-t #{type}" if type
        parts << 'bash'
      end

      exec(script_parts.join(' '))
    end

    def logs(service, env:, follow:, num:)
      raise GLI::UnknownCommand if env.to_sym == :dev

      script_parts = [].tap do |parts|
        parts << "heroku logs -a #{app(env)}"
        parts << "-d #{service}"
        parts << '-t'         if follow
        parts << "-n #{num}"  if num
      end

      exec(script_parts.join(' '))
    end

    def short_env_for(env)
      {
        dev: :dev,
        development: :dev,
        stage: :stage,
        staging: :stage,
        prod: :prod,
        production: :prod
      }[env.to_sym]
    end

    def app(env)
      File.basename(Dir.getwd)
        .split('-')
        .insert(1, short_env_for(env))
        .join('-')
    end
  end
end

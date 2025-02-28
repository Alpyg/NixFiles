{
  programs.nixvim.plugins.codecompanion = {
    enable = true;

    settings = {
      opts = {
        log_level = "TRACE";
        send_code = true;
        use_default_actions = true;
        use_default_prompts = true;
      };
      strategies = {
        agent.adapter = "ollama";
        chat.adapter = "ollama";
        inline.adapter = "ollama";
      };
      adapters = {
        ollama = {
          __raw = ''
            function()
              return require('codecompanion.adapters').extend('ollama', {
                  env = {
                      url = "http://127.0.0.1:11434",
                  },
                  schema = {
                      model = {
                          default = 'deepseek-coder:6.7b',
                      },
                      num_ctx = {
                          default = 32768,
                      },
                  },
              })
            end
          '';
        };
      };
    };
  };
}

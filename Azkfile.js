/**
 * Documentation: http://docs.azk.io/Azkfile.js
 */
// Adds the systems that shape your system
systems({
  pagarmex: {
    // Dependent systems
    depends: [],
    // More images:  http://images.azk.io
    image: {"docker": "azukiapp/elixir:1.2"},
    // Steps to execute before running instances
    provision: [
      "mix do deps.get, compile",
    ],
    workdir: "/azk/#{manifest.dir}",
    command: ["mix", "app.start"],
    wait: false,
    mounts: {
      '/azk/#{manifest.dir}'       : sync("."),
      '/azk/#{manifest.dir}/deps'  : persistent("./deps"),
      '/azk/#{manifest.dir}/_build': persistent("./_build"),
      '/root/.hex'                 : persistent("#{env.HOME}/.hex"),
    },
    envs: {
      // get your PAGARME_API_KEY in https://dashboard.pagar.me/#/myaccount/apikeys
      // NOTE: it is safer to save this value in `.env`
      PAGARME_API_KEY: null,
      MIX_ENV: "test",
    },
  },
});

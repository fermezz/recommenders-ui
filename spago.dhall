{ sources = [ "src/**/*.purs", "test/**/*.purs" ]
, name = "recommenders-ui"
, packages = ./packages.dhall
, dependencies =
  [ "console"
  , "effect"
  , "formatters"
  , "halogen"
  , "prelude"
  , "psci-support"
  , "spec"
  , "exists"
  , "routing"
  , "routing-duplex"
  ]
}

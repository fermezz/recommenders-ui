module Recommenders.Component.HTML.Header where

import Prelude

import Data.Monoid (guard)
import Halogen.HTML as HH
import Recommenders.Component.HTML.Utils (css, safeHref)
import Recommenders.Data.Route (Route(..))

header :: forall i p. Route -> HH.HTML i p
header route =
  HH.nav
    [ css "navbar navbar-light" ]
    [ HH.div
      [ css "container" ]
      [ HH.a
        [ css "navbar-brand"
        , safeHref Home
        ]
        [ HH.text "Recommenders" ]
      , HH.ul
        [ css "nav navbar-nav pull-xs-right" ]
        [ navItem Home
            [ HH.text "Home" ]
        ]
      ]
    ]

  where

  navItem r html =
    HH.li
      [ css "nav-item" ]
      [ HH.a
        [ css $ "nav-link" <> guard (route == r) " active"
        , safeHref r
        ]
        html
      ]

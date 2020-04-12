module Recommenders.Page.NotFound where

import Prelude

import Halogen as H
import Halogen.HTML as HH
import Recommenders.Component.HTML.Utils (css, safeHref)
import Recommenders.Data.Route (Route(..))

type State = { text :: String }

data Action = None

component :: forall q i o m. H.Component HH.HTML q i o m
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval $ H.defaultEval
    }

initialState :: forall i. i -> State
initialState _ = { text: "We couldn't find this page ☹️" }

render :: forall m. State -> H.ComponentHTML Action () m
render state =
  let
    label = state.text
  in
    HH.div
      [ css "text-center bg-notfound" ]
      [ HH.h2
        [ css "center" ]
        [ HH.text label ]
      , HH.a
        [ css "btn btn-lg btn-secondary"
        , safeHref Home
        ]
        [ HH.text "Take me home" ]
      ]

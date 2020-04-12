module Recommenders.Component.Home where

import Prelude

import Halogen as H
import Halogen.HTML as HH
import Recommenders.Component.HTML.Header (header)
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
initialState _ = { text: "Welcome home :)" }

render :: forall m. State -> H.ComponentHTML Action () m
render state =
  let
    label = state.text
  in
    HH.div_
      [ header Home 
      , HH.text label
      ]

module Recommenders.Component.HelloWorld where

import Prelude

import Halogen as H
import Halogen.HTML as HH

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
initialState _ = { text: "Hello World!" }

render :: forall m. State -> H.ComponentHTML Action () m
render state =
  let
    label = state.text
  in
    HH.text label

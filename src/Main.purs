module Main where

import Prelude

import AppM ( runAppM )
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Halogen (liftEffect)
import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.VDom.Driver (runUI)
import Recommenders.Component.Router as Router
import Recommenders.Data.Route (parse, routeCodec)
import Routing.Hash (matchesWith)

main :: Effect Unit
main = HA.runHalogenAff do

  body <- HA.awaitBody
  let
    rootComponent :: H.Component HH.HTML Router.Query {} Void Aff
    rootComponent = H.hoist runAppM Router.component

  halogenIO <- runUI rootComponent {} body

  void $ liftEffect $ matchesWith (parse routeCodec) \old new ->
    when ( old /= Just new ) do
      launchAff_ $ halogenIO.query $ H.tell $ Router.Navigate new

  pure unit

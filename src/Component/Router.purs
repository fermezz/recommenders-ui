module Recommenders.Component.Router where

import Prelude

import Data.Either (hush)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Symbol (SProxy(..))
import Effect.Aff.Class (class MonadAff)
import Halogen (liftEffect)
import Halogen as H
import Halogen.HTML as HH
import Recommenders.Component.HelloWorld as HW
import Recommenders.Capability.Navigate (class Navigate, navigate)
import Recommenders.Data.Route (Route(..), routeCodec)
import Recommenders.Page.NotFound as NF
import Routing.Duplex as RD
import Routing.Hash (getHash)

data Query a
  = Navigate Route a

type State =
  { route :: Maybe Route }

data Action
  = Initialize

type OpaqueSlot slot = forall query. H.Slot query Void slot

type ChildSlots =
  ( helloworld :: OpaqueSlot Unit
  , notfound   :: OpaqueSlot Unit
  )

component
  :: forall m
   . MonadAff m
  => Navigate m
  => H.Component HH.HTML Query {} Void m
component = H.mkComponent
  { initialState: \_ -> { route: Nothing }
  , render
  , eval: H.mkEval $ H.defaultEval
      { handleQuery = handleQuery
      , handleAction = handleAction
      , initialize = Just Initialize
      }
  }
  where
  handleAction :: Action -> H.HalogenM State Action ChildSlots Void m Unit
  handleAction = case _ of
    Initialize -> do
      -- first we'll get the route the user landed on
      initialRoute <- hush <<< (RD.parse routeCodec) <$> liftEffect getHash
      -- then we'll navigate to the new route (also setting the hash)
      navigate $ fromMaybe HelloWorld initialRoute

  handleQuery :: forall a. Query a -> H.HalogenM State Action ChildSlots Void m (Maybe a)
  handleQuery = case _ of
    Navigate dest a -> do
      H.modify_ _ { route = Just dest }
      pure Nothing

  render :: State -> H.ComponentHTML Action ChildSlots m
  render { route } = case route of
    Just r -> case r of
      HelloWorld -> do
        HH.slot (SProxy :: _ "helloworld") unit HW.component {} absurd
      NotFound -> do
        HH.slot (SProxy :: _ "notfound") unit NF.component {} absurd
    Nothing ->
      HH.slot (SProxy :: _ "notfound") unit NF.component {} absurd

module Recommenders.Data.Route where

import Prelude hiding ((/))

import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Maybe (Maybe(..))
import Routing.Duplex (RouteDuplex(..), RouteDuplex', root)
import Routing.Duplex.Generic (noArgs, sum)
import Routing.Duplex.Generic.Syntax ((/))
import Routing.Duplex.Parser (RouteParser, RouteResult(..), parsePath, runRouteParser)

data Route
  = HelloWorld
  | ByeWorld
  | NotFound

derive instance genericRoute :: Generic Route _
derive instance eqRoute :: Eq Route
derive instance ordRoute :: Ord Route

instance showRoute :: Show Route where
  show = genericShow

routeCodec :: RouteDuplex' Route
routeCodec = root $ sum
  { "HelloWorld": noArgs
  , "ByeWorld": "bye" / noArgs
  , "NotFound": "notfound" / noArgs
  }

-- We only need this to be a `Maybe Route` because it won't work with Routing.Hash.matchesWith otherwise
-- TODO: Figure out how to simply return a `Route`.
run :: RouteParser Route -> String -> Maybe Route
run p = parsePath >>> flip runRouteParser p >>> case _ of
  Fail    _     -> Just NotFound
  Success _ res -> Just res

parse :: forall i. RouteDuplex i Route -> String -> Maybe Route
parse (RouteDuplex _ dec) = run dec


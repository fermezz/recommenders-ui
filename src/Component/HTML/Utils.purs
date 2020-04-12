module Recommenders.Component.HTML.Utils where

import Prelude

import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Recommenders.Data.Route (Route, routeCodec)
import Routing.Duplex (print)

css :: forall r i. String -> HH.IProp ( class :: String | r ) i
css = HP.class_ <<< HH.ClassName

-- | We must provide a `String` to the "href" attribute, but we represent routes with the much
-- | better `Route` type. This utility is a drop-in replacement for `href` that uses `Route`.
safeHref :: forall r i. Route -> HH.IProp ( href :: String | r) i
safeHref = HP.href <<< append "#" <<< print routeCodec

module Web.Controller.Static where
import Web.Controller.Prelude
import Web.View.Static.Welcome
import qualified IHP.Log as Log

instance Controller StaticController where
    action WelcomeAction = do
        Log.debug "Logging Operational."
        render WelcomeView

module Web.View.Static.Welcome where
import Web.View.Prelude
import IHP.LoginSupport.Helper.View

data WelcomeView = WelcomeView

instance View WelcomeView where
    html WelcomeView = [hsx|
                            <p> <a href={NewSessionAction}> Login </a> </p>
                            <p> <a href={DeleteSessionAction}> Logout </a> </p>
                            { renderGreetAdmin currentAdminOrNothing }
                       |]

renderGreetAdmin :: Maybe Admin -> Html
renderGreetAdmin Nothing = [hsx| No Admin Login. |]
renderGreetAdmin (Just admin) = [hsx| Greetings Admin. |]

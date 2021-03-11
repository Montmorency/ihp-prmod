module Web.Controller.Admins where

import Web.Controller.Prelude
import Web.View.Admins.Index
import Web.View.Admins.New
import Web.View.Admins.Edit
import Web.View.Admins.Show

instance Controller AdminsController where
    action AdminsAction = do
        admins <- query @Admin |> fetch
        render IndexView { .. }

    action NewAdminAction = do
        let admin = newRecord
        render NewView { .. }

    action ShowAdminAction { adminId } = do
        admin <- fetch adminId
        render ShowView { .. }

    action EditAdminAction { adminId } = do
        admin <- fetch adminId
        render EditView { .. }

    action UpdateAdminAction { adminId } = do
        admin <- fetch adminId
        admin
            |> buildAdmin
            |> ifValid \case
                Left admin -> render EditView { .. }
                Right admin -> do
                    hashed <- hashPassword (get #passwordHash admin)
                    admin <- admin 
                                |> set #passwordHash hashed
                                |> updateRecord
                    setSuccessMessage "Admin updated"
                    redirectTo EditAdminAction { .. }

    action CreateAdminAction = do
        let admin = newRecord @Admin
        admin
            |> buildAdmin
            |> ifValid \case
                Left admin -> render NewView { .. } 
                Right admin -> do
                    hashed <- hashPassword (get #passwordHash admin)
                    admin <- admin 
                                |> set #passwordHash hashed
                                |> createRecord
                    setSuccessMessage "Admin created"
                    redirectTo AdminsAction

    action DeleteAdminAction { adminId } = do
        admin <- fetch adminId
        deleteRecord admin
        setSuccessMessage "Admin deleted"
        redirectTo AdminsAction

buildAdmin admin = admin
    |> fill @["name","email","passwordHash","failedLoginAttempts"]

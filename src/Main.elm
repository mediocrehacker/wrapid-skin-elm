port module Main exposing (main)

import ManageRole as ManageRole
import Types exposing (Role, initRoles)
import Html exposing (Html, a, button, div, h1, img, li, p, text, ul, input)
import Html.Attributes exposing (href, src, placeholder, style)
import Html.Events exposing (onClick, onInput)
import Navigation as Nav
import List.Extra exposing (find)
import WrapidLogo exposing (logo)
import Maybe exposing (andThen)
import Table

main : Program Never Model Msg
main =
    Nav.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }



-- MODEL


type alias Model =
    { history : List Nav.Location
    , profiles : List Profile
    , currentImg : Maybe String
    , manageRole : ManageRole.Model
    , roles : List Role
    , tableState : Table.State
    , query : String
    , dialogOpened : Bool
    }


type alias Url =
    String


type alias Profile =
    { id : String
    , firstName : String
    , url : Maybe String
    }


initModel : Nav.Location -> Model
initModel location =
    Model [ location ] [] Nothing  ManageRole.init initRoles (Table.initialSort "Role") "" False

init : Nav.Location -> (Model, Cmd Msg)
init location =
    ( initModel location, Cmd.none )


-- UPDATE


type Msg
    = UrlChange Nav.Location
    | ShowAvatar String
    | SetQuery String
    | SetTableState Table.State
    | ToggleDialog
    | AddRole
    | ManageRoleMsg ManageRole.Msg



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "msg: " msg of
        UrlChange location ->
            ( { model | history = location :: model.history }
            , Cmd.none
            )

        SetQuery newQuery ->
            ( { model | query = newQuery }
            , Cmd.none )

        ToggleDialog ->
            ( { model | dialogOpened = not model.dialogOpened }
            , Cmd.none )


        ShowAvatar id ->
            let
                clickedUser =
                    find (\usr -> usr.id == id) model.profiles

                url =
                    andThen .url clickedUser
            in
                ( { model | currentImg = url }
                , Cmd.none
                )

        SetTableState newState ->
            ( { model | tableState = newState }
            , Cmd.none
            )


        ManageRoleMsg subMsg ->
                let
                    _ = Debug.log "model: " model
                    ( updatedManageRoleModel, manageRoleCmd ) =
                        ManageRole.update subMsg model.manageRole
                in
                    ( { model | manageRole = updatedManageRoleModel }
                    , Cmd.map ManageRoleMsg manageRoleCmd
                    )
        AddRole ->
            ( { model | roles = model.roles ++ [model.manageRole] }
            , Cmd.none
            )

        -- _ ->
        --     (model, Cmd.none)

-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ -- logo
        h1 [] [ text "Pages" ]
        , ul [] (List.map viewLink [ "bears", "cats", "dogs", "elephants", "fish" ])
        , h1 [] [ text "History" ]
        , ul [] (List.map viewLocation model.history)
        , h1 [] [ text "Data" ]
        , viewManageRole model.dialogOpened model.manageRole
        , viewTableWithSearch model.roles model.tableState model.query
        , viewAvatar model.currentImg
        ]

viewManageRole : Bool -> ManageRole.Model -> Html Msg
viewManageRole bool manageRolesModel =
    if bool then
        div [] []
    else
        div []
            [ Html.map ManageRoleMsg (ManageRole.view manageRolesModel)
            , button [ onClick AddRole ] [ text "ADD ROLE" ] ]

viewTableWithSearch : List Role -> Table.State -> String -> Html Msg
viewTableWithSearch roles tableState query =
    let
        lowerQuery =
            String.toLower query

        acceptableRole =
            List.filter (String.contains lowerQuery << String.toLower << .role) roles
    in
        div []
            [ input [ placeholder "Search by Role", onInput SetQuery ] []
            , button [ onClick ToggleDialog ] [ text "ADD" ]
            , viewTable tableState acceptableRole
            ]


viewTable : Table.State -> List Role -> Html Msg
viewTable tableState roles =
    Table.view config tableState roles

config : Table.Config Role Msg
config =
  Table.config
    { toId = .role
    , toMsg = SetTableState
    , columns =
        [ Table.stringColumn "Role" .role
        , Table.stringColumn "First" .first
        , Table.stringColumn "Last" .last
        , Table.stringColumn "Call Start" .callStart
        , Table.stringColumn "Pay" .pay
        , Table.stringColumn "Lunch Start" .lunchStart
        , Table.stringColumn "Lunch length" .lunchLength
        , Table.stringColumn "In" .roleIn
        , Table.stringColumn "Out" .roleOut
        , Table.stringColumn "Call End" .callEnd
        , Table.stringColumn "Email" .email
        ]
    }

viewLink : String -> Html msg
viewLink name =
    li [] [ a [ href ("#" ++ name) ] [ text name ] ]


viewLocation : Nav.Location -> Html msg
viewLocation location =
    li [] [ text (location.pathname ++ location.hash) ]



viewAvatar : Maybe String -> Html msg
viewAvatar url =
    case url of
        Nothing ->
            text ""

        Just loc ->
            img [ src loc ] []



-- PORTS


-- SUBSCRIPTIONS


-- Skin Date

-- Action TOP
-- Search
-- Edit
-- Add

-- Action Bottom
-- Breakdown
-- Export CSV
-- Wrap Skin

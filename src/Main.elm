port module Main exposing (main)

import ManageRoles as ManageRoles
import Types exposing (Role)
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
    , manageRoles : List Role
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
    Model [ location ] [] Nothing [] [] (Table.initialSort "Role") "" False

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
    | ManageRolesMsg ManageRoles.Msg



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
            ( { model | dialogOpened = not model.dialogOpened}
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


        -- AddRoleMsg subMsg ->
        --         let
        --             ( updatedRoleModel, roleCmd ) =
        --                 Wizard.update subMsg model.wizardModel
        --         in
        --             ( { model | wizardModel = updatedWizardModel }
        --             , Cmd.map WizardMsg wizardCmd
        --             )

        _ ->
            (model, Cmd.none)

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
        , Html.map ManageRolesMsg (ManageRoles.view model.manageRoles)
        , viewTableWithSearch model.roles model.tableState model.query
        , viewAvatar model.currentImg
        ]


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
        , Table.stringColumn "Lunch Start" .lunch_start
        , Table.stringColumn "Lunch length" .lunch_length
        , Table.stringColumn "In" .roleIn
        , Table.stringColumn "Out" .roleOut
        , Table.stringColumn "Call End" .call_end
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

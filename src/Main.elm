port module Main exposing (main)

import Html exposing (Html, a, button, div, h1, img, li, p, text, ul, input)
import Html.Attributes exposing (href, src, placeholder)
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
    , roles : List Role
    , tableState : Table.State
    , query : String
    }


type alias Url =
    String


type alias Profile =
    { id : String
    , firstName : String
    , url : Maybe String
    }


init : Nav.Location -> ( Model, Cmd Msg )
init location =
    ( Model [ location ] [] Nothing defaultRoles (Table.initialSort "Role") ""
    , Cmd.none
    )



-- UPDATE


type Msg
    = UrlChange Nav.Location
    | ShowAvatar String
    | SetQuery String
    | SetTableState Table.State


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            ( { model | history = location :: model.history }
            , Cmd.none
            )

        SetQuery newQuery ->
            ( { model | query = newQuery }
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


-- ROLE

type alias Role =
    { role : String
    , first : String
    , last : String
    , callStart : String
    , pay: String
    , lunch_start : String
    , lunch_length : String
    , roleIn : String
    , roleOut : String
    , call_end : String
    , email : String
    }


defaultRoles : List Role
defaultRoles =
    [ Role "Zombie Extra" "Josh" "Weinberg" "8:00 Am" "$ 125/12" "12:00" "1 hr" "" "" "5:00PM" "josh@gmail.com"
    , Role "Zombie Super Extra" "Josh" "Weinberg" "8:00 Am" "$ 125/12" "12:00" "1 hr" "" "" "5:00PM" "josh@gmail.com"
    , Role "Cop Extra" "Peter" "Geit" "9:00 Am" "$ 130/12" "11:00" "1 hr" "" "" "5:00PM" "joshBig@gmail.com"
    , Role "Thief Extra" "Peter" "Geit" "9:00 Am" "$ 145/12" "13:00" "1 hr" "" "" "6:00PM" "joshBIg@gmail.com"
    , Role "Thief Extra" "Max" "Marra" "8:30 Am" "$ 150/6" "14:00" "1 hr" "" "" "8:00PM" "joshSmall@gmail.com"
    , Role "Zombie Extra" "Josh" "Weinberg" "8:40 Am" "$ 100/12" "13:30" "1.5 hr" "" "" "7:00PM" "joshTall@gmail.com"
    , Role "Zombie Extra" "Josh" "Weinberg" "8:15 Am" "$ 50/12" "14:15" "2 hr" "" "" "5:00PM" "peter@gmail.com"
    ]

-- defaultOneRole : Role
-- defaultOneRole =
--     { role = "Zombie Extra"
--     , first = "Josh"
--     , last = "Weinberg"
--     , callStart = "8:00 Am"
--     , pay= "$ 125/12"
--     , lunch_start = "12:00"
--     , lunch_length = "1 hr"
--     , roleIn = ""
--     , roleOut = ""
--     , call_end = "5:00PM"
--     , email = "josh@gmail.com"
--     }

-- Skin Date

-- Action TOP
-- Search
-- Edit
-- Add

-- Action Bottom
-- Breakdown
-- Export CSV
-- Wrap Skin

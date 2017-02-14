module ManageRoles exposing (..)

import Html exposing (Html, text, input, div, p)
import Html.Attributes exposing (placeholder, style)
import Html.Events exposing (onInput)
import Types exposing (Role)

-- MODEL

type alias Model =
    List Role


initModel : List Role
initModel =
    [ Role "Zombie Extra" "Josh" "Weinberg" "8:00 Am" "$ 125/12" "12:00" "1 hr" "" "" "5:00PM" "josh@gmail.com"
    , Role "Zombie Super Extra" "Josh" "Weinberg" "8:00 Am" "$ 125/12" "12:00" "1 hr" "" "" "5:00PM" "josh@gmail.com"
    , Role "Cop Extra" "Peter" "Geit" "9:00 Am" "$ 130/12" "11:00" "1 hr" "" "" "5:00PM" "joshBig@gmail.com"
    , Role "Thief Extra" "Peter" "Geit" "9:00 Am" "$ 145/12" "13:00" "1 hr" "" "" "6:00PM" "joshBIg@gmail.com"
    , Role "Thief Extra" "Max" "Marra" "8:30 Am" "$ 150/6" "14:00" "1 hr" "" "" "8:00PM" "joshSmall@gmail.com"
    , Role "Zombie Extra" "Josh" "Weinberg" "8:40 Am" "$ 100/12" "13:30" "1.5 hr" "" "" "7:00PM" "joshTall@gmail.com"
    , Role "Zombie Extra" "Josh" "Weinberg" "8:15 Am" "$ 50/12" "14:15" "2 hr" "" "" "5:00PM" "peter@gmail.com"
    ]

-- ACTION, UPDATE

type Msg
    =  UpdAmount String
    | UpdRole String
    | UpdFirst String
    | UpdLast String
    | UpdCallstart String
    | UpdPa String
    | UpdLunchStart String
    | UpdLunchLength String
    | UpdRoleIn String
    | UpdRoleOut String
    | UpdCallEnd String
    | UpdEmail String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "role msg: " msg of
        _ ->
            (model, Cmd.none)


-- View


view : Model -> Html Msg
view model =
    let
        display =
            if False then
                style [("display", "none")]
            else
                style [("display", "block")]
    in
        div [ display ]
            [ p [] [ text ""]
            , input [ placeholder "Amount ", onInput UpdAmount ] []
            , input [ placeholder "Role", onInput UpdRole ] []
            , input [ placeholder "First", onInput UpdFirst ] []
            , input [ placeholder "Last", onInput UpdLast ] []
            , input [ placeholder "Call Start", onInput UpdCallstart ] []
            , input [ placeholder "Pay", onInput UpdPa ] []
            , input [ placeholder "Lunch Start", onInput UpdLunchStart ] []
            , input [ placeholder "Lunch length", onInput UpdLunchLength ] []
            , input [ placeholder "In", onInput UpdRoleIn ] []
            , input [ placeholder "Out", onInput UpdRoleOut ] []
            , input [ placeholder "Call End", onInput UpdCallEnd ] []
            , input [ placeholder "Email", onInput UpdEmail ] []
            , Html.hr [] []
            ]

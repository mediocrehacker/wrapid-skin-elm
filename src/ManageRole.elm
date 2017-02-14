module ManageRole exposing (..)

import Html exposing (Html, text, input, div, p)
import Html.Attributes exposing (placeholder, style)
import Html.Events exposing (onInput)
import Types exposing (Role)

-- MODEL

type alias Model =
    Role

init =
    Role "" "" "" "" "" "" "" "" "" "" ""

-- ACTION, UPDATE

type Msg
    = UpdRole String
    | UpdFirst String
    | UpdLast String
    | UpdCallstart String
    | UpdPay String
    | UpdLunchStart String
    | UpdLunchLength String
    | UpdRoleIn String
    | UpdRoleOut String
    | UpdCallEnd String
    | UpdEmail String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "role msg: " msg of
        UpdRole str ->
            ( { model | role = str }
            , Cmd.none)
        UpdFirst str ->
            ( { model | first = str}
            , Cmd.none)
        UpdLast str ->
            ( { model | last = str}
            , Cmd.none)
        UpdCallstart str ->
            ( { model | callStart = str }
            , Cmd.none)
        UpdPay str ->
            ( { model | pay = str }
            , Cmd.none)
        UpdLunchStart str ->
            ( { model | lunch_start = str }
            , Cmd.none)
        UpdLunchLength str ->
            ( { model | lunch_length = str}
            , Cmd.none)
        UpdRoleIn str ->
            ( { model | roleIn = str}
            , Cmd.none)
        UpdRoleOut str ->
            ( { model | roleOut = str}
            , Cmd.none)
        UpdCallEnd str ->
            ( { model | call_end = str}
            , Cmd.none)
        UpdEmail str ->
            ( { model | email = str}
            , Cmd.none)


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
            , input [ placeholder "Role", onInput UpdRole ] []
            , input [ placeholder "First", onInput UpdFirst ] []
            , input [ placeholder "Last", onInput UpdLast ] []
            , input [ placeholder "Call Start", onInput UpdCallstart ] []
            , input [ placeholder "Pay", onInput UpdPay ] []
            , input [ placeholder "Lunch Start", onInput UpdLunchStart ] []
            , input [ placeholder "Lunch length", onInput UpdLunchLength ] []
            , input [ placeholder "In", onInput UpdRoleIn ] []
            , input [ placeholder "Out", onInput UpdRoleOut ] []
            , input [ placeholder "Call End", onInput UpdCallEnd ] []
            , input [ placeholder "Email", onInput UpdEmail ] []
            , Html.hr [] []
            ]

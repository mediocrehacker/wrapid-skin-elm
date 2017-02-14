module ManageRole exposing (..)

import Html exposing (Html, text, input, div, p)
import Html.Attributes exposing (placeholder, style, value)
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
            ( { model | lunchStart = str }
            , Cmd.none)
        UpdLunchLength str ->
            ( { model | lunchLength = str}
            , Cmd.none)
        UpdRoleIn str ->
            ( { model | roleIn = str}
            , Cmd.none)
        UpdRoleOut str ->
            ( { model | roleOut = str}
            , Cmd.none)
        UpdCallEnd str ->
            ( { model | callEnd = str}
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
            , input [ placeholder "Role", onInput UpdRole, value model.role ] []
            , input [ placeholder "First", onInput UpdFirst, value model.first ] []
            , input [ placeholder "Last", onInput UpdLast, value model.last ] []
            , input [ placeholder "Call Start", onInput UpdCallstart, value model.callStart ] []
            , input [ placeholder "Pay", onInput UpdPay, value model.pay ] []
            , input [ placeholder "Lunch Start", onInput UpdLunchStart, value model.lunchStart ] []
            , input [ placeholder "Lunch length", onInput UpdLunchLength, value model.lunchLength ] []
            , input [ placeholder "In", onInput UpdRoleIn, value model.roleIn ] []
            , input [ placeholder "Out", onInput UpdRoleOut, value model.roleOut ] []
            , input [ placeholder "Call End", onInput UpdCallEnd, value model.callEnd ] []
            , input [ placeholder "Email", onInput UpdEmail, value model.email] []
            , Html.hr [] []
            ]

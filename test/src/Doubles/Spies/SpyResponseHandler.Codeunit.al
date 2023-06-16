codeunit 50226 "Spy ResponseHandler" implements "IMidJourneySend ResponseHandler"
{
    SingleInstance = true;

    var
        ResponseText: Text;

    procedure HandleResponse(var Response: HttpResponseMessage);
    begin
        ResponseText := 'Handled';
    end;

    procedure GetResponseText(): Text;
    begin
        exit(ResponseText);
    end;

    procedure WasCalled(): Boolean;
    begin
        exit(ResponseText <> '');
    end;
}
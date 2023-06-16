codeunit 50226 "Spy ResponseHandler" implements "IMidJourneySend ResponseHandler"
{
    SingleInstance = true;

    var
        _responseText: Text;

    procedure HandleResponse(var Response: HttpResponseMessage);
    begin
        _responseText := 'Handled';
    end;

    procedure GetResponseText(): Text;
    begin
        exit(_responseText);
    end;

    procedure WasCalled(): Boolean;
    begin
        exit(_responseText <> '');
    end;
}
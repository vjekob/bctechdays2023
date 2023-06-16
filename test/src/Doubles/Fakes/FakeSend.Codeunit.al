codeunit 50227 "Fake Send" implements IMidjourneySend
{
    var
        _setup: Record "Midjourney Setup";
        _responseHandler: Interface "IMidJourneySend ResponseHandler";

    procedure Initialize(var SetupIn: Record "Midjourney Setup"; ResponseHandler: Interface "IMidJourneySend ResponseHandler")
    begin
        _setup := SetupIn;
        _responseHandler := ResponseHandler;
    end;

    procedure Send(Path: Text; RequestBody: JsonObject) ResponseBody: JsonObject;
    var
        Response: HttpResponseMessage;
    begin
        ResponseBody.ReadFrom('{"imageURL": "http://www.waldo.be", "status": "Done"}');

        _responseHandler.HandleResponse(Response);
    end;

}
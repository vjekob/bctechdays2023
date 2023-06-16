codeunit 50227 "Fake Send" implements IMidJourneySend
{
    procedure Send(Path: Text; var Setup: Record "Midjourney Setup"; RequestBody: JsonObject; ResponseHandler: Interface "IMidJourneySend ResponseHandler") ResponseBody: JsonObject
    var
        Response: HttpResponseMessage;
    begin
        ResponseBody.ReadFrom('{"imageURL": "http://www.waldo.be", "status": "Done"}');

        ResponseHandler.HandleResponse(Response);
    end;
}
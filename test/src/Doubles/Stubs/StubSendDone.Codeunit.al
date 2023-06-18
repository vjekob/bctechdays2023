codeunit 50241 "Stub Send - Done" implements IMidjourneySend
{
    var
        _imageURL: Text;

    procedure SetImageURL(ImageURL: Text);
    begin
        _imageURL := ImageURL;
    end;

    procedure Send(Path: Text; RequestBody: JsonObject) ResponseBody: JsonObject;
    begin
        ResponseBody.ReadFrom(StrSubstNo('{ "imageURL": "%1" }', _imageURL));
    end;
}

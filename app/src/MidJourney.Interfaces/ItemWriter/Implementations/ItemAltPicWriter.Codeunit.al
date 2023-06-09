codeunit 50011 "Item Alt-Pic Writer" implements IItemWriter
{
    var
        MimeTypeTok: Label 'image/jpeg', Locked = true;

    procedure WriteMedia(var InStr: InStream; Description: Text; var Item: Record Item) MediaId: Integer;
    begin
        Clear(Item."Alternative Picture");
        Item."Alternative Picture".ImportStream(InStr, Description, MimeTypeTok);
        Item.Modify(true);
    end;
}
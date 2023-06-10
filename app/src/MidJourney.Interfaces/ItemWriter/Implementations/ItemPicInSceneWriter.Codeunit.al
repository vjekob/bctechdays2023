codeunit 50012 "Item Pic-In-Scene Writer" implements IItemWriter
{
    var
        MimeTypeTok: Label 'image/jpeg', Locked = true;

    procedure WriteMedia(var InStr: InStream; Description: Text; var Item: Record Item) MediaId: Integer;
    begin
        Clear(Item."Pic-In-Scene");
        Item."Pic-In-Scene".ImportStream(InStr, Description, MimeTypeTok);
        Item.Modify(true);
    end;
}
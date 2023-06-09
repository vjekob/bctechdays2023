interface "IItemWriter"
{
    procedure WriteMedia(var InStr: InStream; Description: Text; var Item: Record Item) MediaId: Integer;
}
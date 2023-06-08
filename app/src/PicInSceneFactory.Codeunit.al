codeunit 50015 "Pic-In-Scene Factory"
{
    #region ImageGenerator
    var
        _ImageGenerator: Interface "IMidJourney Generator";
        _ImageGeneratorIsDefined: Boolean;

    procedure ImageGenerator(): Interface "IMidJourney Generator"
    var
        PicInSceneGenerator: Codeunit "Pic-In-Scene Generator";
    begin
        if not _ImageGeneratorIsDefined then
            SetImageGenerator(PicInSceneGenerator);

        exit(_ImageGenerator);
    end;

    local procedure SetImageGenerator(IImageGenerator: Interface "IMidJourney Generator")
    begin
        _ImageGenerator := IImageGenerator;
        _ImageGeneratorIsDefined := true;
    end;
    #endregion ImageGenerator

    #region ItemWriter
    var
        _ItemWriter: Interface IItemWriter;
        _ItemWriterIsDefined: Boolean;

    procedure ItemWriter(): Interface IItemWriter
    var
        ItemPicInSceneWriter: Codeunit "Item Pic-In-Scene Writer";
    begin
        if not _ItemWriterIsDefined then
            SetItemWriter(ItemPicInSceneWriter);

        exit(_ItemWriter);
    end;

    local procedure SetItemWriter(IItemWriter: Interface IItemWriter)
    begin
        _ItemWriter := IItemWriter;
        _ItemWriterIsDefined := true;
    end;
    #endregion ItemWriter

    #region ImageDownloader
    var
        _ImageDownloader: Interface IImageDownloader;
        _ImageDownloaderIsDefined: Boolean;

    procedure ImageDownloader(): Interface IImageDownloader
    var
        DownloadImage: Codeunit "Download Image";
    begin
        if not _ImageDownloaderIsDefined then
            SetImageDownloader(DownloadImage);

        exit(_ImageDownloader);
    end;

    local procedure SetImageDownloader(IImageDownloader: Interface IImageDownloader)
    begin
        _ImageDownloader := IImageDownloader;
        _ImageDownloaderIsDefined := true;
    end;
    #endregion ImageDownloader
}
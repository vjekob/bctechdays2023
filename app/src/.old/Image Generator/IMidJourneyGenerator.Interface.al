interface "IMidJourney Generator"
{
    procedure GenerateImage(prompt: Text) TaskId: Text;
    procedure Result(TaskId: Text) imageUrl: Text;
    //Upscale?
    //Seed?
}
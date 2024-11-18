local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

-- Max all render settings
settings().Rendering.QualityLevel = 21 
settings().Rendering.GraphicsMode = 2

-- Remove default effects
for _, item in pairs(Lighting:GetChildren()) do
   item:Destroy()
end

-- Ultra quality lighting
Lighting.Technology = Enum.Technology.Future
Lighting.ShadowSoftness = 0
Lighting.GlobalShadows = true
Lighting.ShadowColor = Color3.fromRGB(178, 178, 183)
Lighting.ExposureCompensation = 0.03
Lighting.EnvironmentDiffuseScale = 1
Lighting.EnvironmentSpecularScale = 1
Lighting.Brightness = 2.5
Lighting.ClockTime = 14.5
Lighting.GeographicLatitude = 45
Lighting.Ambient = Color3.fromRGB(150, 150, 150)
Lighting.OutdoorAmbient = Color3.fromRGB(150, 150, 150)
Lighting.FogColor = Color3.fromRGB(192, 192, 192)
Lighting.FogEnd = 10000
Lighting.FogStart = 0

-- Premium effects
local bloom = Instance.new("BloomEffect")
bloom.Intensity = 1
bloom.Size = 24 
bloom.Threshold = 0.5
bloom.Parent = Lighting

local colorCorrection = Instance.new("ColorCorrectionEffect")
colorCorrection.Brightness = 0.03
colorCorrection.Contrast = 0.15
colorCorrection.Saturation = 0.15
colorCorrection.TintColor = Color3.fromRGB(255, 255, 255)
colorCorrection.Parent = Lighting

local sunRays = Instance.new("SunRaysEffect")
sunRays.Intensity = 0.03
sunRays.Spread = 0.5
sunRays.Parent = Lighting

local atmosphere = Instance.new("Atmosphere")
atmosphere.Density = 0.35
atmosphere.Offset = 0
atmosphere.Color = Color3.fromRGB(199, 190, 198)
atmosphere.Decay = Color3.fromRGB(106, 112, 125)
atmosphere.Glare = 0.3
atmosphere.Haze = 2
atmosphere.Parent = Lighting

local blur = Instance.new("BlurEffect")
blur.Size = 2
blur.Parent = Lighting

local sky = Instance.new("Sky")
sky.CelestialBodiesShown = true
sky.MoonAngularSize = 11
sky.MoonTextureId = "rbxassetid://8139665943"
sky.SkyboxBk = "rbxassetid://8139663516"
sky.SkyboxDn = "rbxassetid://8139663779"
sky.SkyboxFt = "rbxassetid://8139663231"
sky.SkyboxLf = "rbxassetid://8139663620"
sky.SkyboxRt = "rbxassetid://8139663891"
sky.SkyboxUp = "rbxassetid://8139664117"
sky.StarCount = 5000
sky.SunAngularSize = 21
sky.SunTextureId = "rbxassetid://8139665453"
sky.Parent = Lighting

-- Max quality textures
game:GetService("TextureQuality", 1024)

-- HD Material replacements
local function enhanceObject(object)
   if object:IsA("BasePart") then
       -- Set high quality for every material type
       object.TextureID = "rbxassetid://9438453972" -- Replace with HD texture
       object.Material = object.Material -- Keep original material type
       object.Reflectance = 0.2
       object.CastShadow = true
   end
   
   if object:IsA("Texture") then
       object.StudsPerTileU = 2
       object.StudsPerTileV = 2
   end
   
   if object:IsA("ParticleEmitter") then
       object.LightEmission = 1
       object.LightInfluence = 0
       object.Texture = "rbxassetid://9438453972" -- HD particle texture
   end
   
   if object:IsA("Fire") or object:IsA("Smoke") then
       object.Heat = 10
       object.Size = 5
   end
   
   if object:IsA("Sparkles") then
       object.SparkleColor = Color3.new(1, 1, 1)
   end
   
   if object:IsA("PointLight") or object:IsA("SpotLight") or object:IsA("SurfaceLight") then
       object.Shadows = true
       object.Range = object.Range * 2
   end
end

-- Apply HD enhancement to everything
for _, obj in pairs(workspace:GetDescendants()) do
   enhanceObject(obj)
end

workspace.DescendantAdded:Connect(enhanceObject)

-- Dynamic time cycle
local function timeCycle()
   while wait(0.1) do
       local tweenInfo = TweenInfo.new(300, Enum.EasingStyle.Linear)
       local tween = TweenService:Create(Lighting, tweenInfo, {ClockTime = 24})
       tween:Play()
       wait(300)
       Lighting.ClockTime = 0
   end
end
coroutine.wrap(timeCycle)()

-- Set high quality for terrain
workspace.Terrain.WaterColor = Color3.fromRGB(12, 84, 91)
workspace.Terrain.WaterReflectance = 1
workspace.Terrain.WaterTransparency = 0.9
workspace.Terrain.WaterWaveSize = 0.15
workspace.Terrain.WaterWaveSpeed = 10

-- Force high quality on character models
local function enhanceCharacter(character)
   for _, part in pairs(character:GetDescendants()) do
       if part:IsA("BasePart") then
           part.TextureID = "rbxassetid://9438453972"
           part.Material = Enum.Material.SmoothPlastic
           part.Reflectance = 0.1
       end
   end
end

game.Players.PlayerAdded:Connect(function(player)
   player.CharacterAdded:Connect(enhanceCharacter)
end)

local bone = require("include.lovebone");

local mySkeleton = bone.newSkeleton();


local UpperSpine = bone.newBone(nil, 1, {0,0}, 0, {0,0}, {1.5, 1.5});

UpperSpine.Width = 20;
UpperSpine.Height = 20;
mySkeleton:SetBone("UpperSpine", UpperSpine);



local Neck = bone.newBone("UpperSpine", 2, {0,-20}, 0, {0,0}, {1, 1});
Neck.Width = 20;
Neck.Height = 30;
mySkeleton:SetBone("Neck", Neck);
local Skull = bone.newBone("Neck", 3, {0,-40}, 0, {0,0}, {1, 1});
mySkeleton:SetBone("Skull", Skull);
Skull.Width = 50;
Skull.Height = 50;


local UpperLeftArm = bone.newBone("UpperSpine", 2,  {25,10}, math.rad(-25), {0,0}, {1, 1});
UpperLeftArm.Width = 20;
UpperLeftArm.Height = 40;
mySkeleton:SetBone("UpperLeftArm", UpperLeftArm);
local LowerLeftArm = bone.newBone("UpperLeftArm", 3,  {0,40}, math.rad(20), {0,0}, {1, 1});
LowerLeftArm.Width = 15;
LowerLeftArm.Height = 40;
mySkeleton:SetBone("LowerLeftArm", LowerLeftArm);
local LeftWrist = bone.newBone("LowerLeftArm", 4,  {0,40}, math.rad(-10), {0,0}, {1, 1});
LeftWrist.Width = 20;
LeftWrist.Height = 20;
mySkeleton:SetBone("LeftWrist", LeftWrist);

local UpperRightArm = bone.newBone("UpperSpine", 2, {-25,10}, 0, {0,0}, {1, 1});
UpperRightArm.Width = 20;
UpperRightArm.Height = 40;
--UpperRightArm:SetDefaultRotation(-math.rad(45));
mySkeleton:SetBone("UpperRightArm", UpperRightArm);
local LowerRightArm = bone.newBone("UpperRightArm", 3, {0,40}, 0, {0,0}, {1, 1});
LowerRightArm.Width = 15;
LowerRightArm.Height = 40;
mySkeleton:SetBone("LowerRightArm", LowerRightArm);
local RightWrist = bone.newBone("LowerRightArm", 4, {0,40}, 0, {0,0}, {1, 1});
RightWrist.Width = 20;
RightWrist.Height = 20;
mySkeleton:SetBone("RightWrist", RightWrist);

local LowerSpine = bone.newBone("UpperSpine", 2, {0,100}, 0, {0,0}, {1, 1});
mySkeleton:SetBone("LowerSpine", LowerSpine);

local UpperLeftLeg = bone.newBone("LowerSpine", 2, {-15,20}, 0, {0,0}, {1, 1});
UpperLeftLeg.Width = 20;
UpperLeftLeg.Height = 50;
mySkeleton:SetBone("UpperLeftLeg", UpperLeftLeg);
local LowerLeftLeg = bone.newBone("UpperLeftLeg", 3, {0,50}, 0, {0,0}, {1, 1});
LowerLeftLeg.Width = 15;
LowerLeftLeg.Height = 50;
mySkeleton:SetBone("LowerLeftLeg", LowerLeftLeg);
local LeftAnkle = bone.newBone("LowerLeftLeg", 4, {0,35}, 0, {0,0}, {1, 1}); -- Rename to Foot?
LeftAnkle.Width = 20;
LeftAnkle.Height = 20;
mySkeleton:SetBone("LeftAnkle", LeftAnkle);

local UpperRightLeg = bone.newBone("LowerSpine", 2, {15,20}, 0, {0,0}, {1, 1});
UpperRightLeg.Width = 20;
UpperRightLeg.Height = 50;

mySkeleton:SetBone("UpperRightLeg", UpperRightLeg);
local LowerRightLeg = bone.newBone("UpperRightLeg", 3, {0,50}, 0, {0,0}, {1, 1});
LowerRightLeg.Width = 15;
LowerRightLeg.Height = 50;
mySkeleton:SetBone("LowerRightLeg", LowerRightLeg);
local RightAnkle = bone.newBone("LowerRightLeg", 4, {0,35}, 0, {0,0}, {1, 1});
RightAnkle.Width = 20;
RightAnkle.Height = 20;
mySkeleton:SetBone("RightAnkle", RightAnkle);

--mySkeleton:GetBone("LowerRightLeg").rotation = math.rad(50);

mySkeleton:Validate();
print(mySkeleton:IsValid());

return mySkeleton;
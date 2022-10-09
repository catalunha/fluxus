
Parse.Cloud.afterSave(Parse.User, async (req) => {
  let user = req.object;
  console.log(`afterSave User with ${user.email}. Create profile.`);

  if (user.get('profile') === undefined) {
    const profile = new Parse.Object("Profile");
    profile.set('email', user.get('email'));
    profile.set('userId', user.id);
    let profileResult = await profile.save(null, { useMasterKey: true });
    user.set('profile', profileResult);
    await user.save(null, { useMasterKey: true });
  }
});

Parse.Cloud.afterDelete(Parse.User, async (req) => {
  let user = req.object;

  console.log(`afterDelete user ${user.id}`);
  let profileId = user.get('profile').id;
  console.log(`deleting profile ${profileId}`);
  const profile = new Parse.Object("profile");
  profile.id = profileId;
  await profile.destroy({ useMasterKey: true });
});

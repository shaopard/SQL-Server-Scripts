DECLARE @NewLoginName VARCHAR(50) = 'abuda';

DECLARE @NewFirstName VARCHAR(50) = 'Adrian';
DECLARE @NewLastName VARCHAR(50) = 'Buda';

DECLARE @NewUserId INT = 0;

If NOT EXISTS(SELECT 1 FROM [User] WHERE [LoginName] LIKE @NewLoginName)
	BEGIN
		-- Insert the new user
		INSERT INTO [User] (LoginName, FirstName, LastName, DomainID) 
		VALUES(@NewLoginName, @NewFirstName, @NewLastName, 1);

		-- @@IDENTITY is the primary key of the last modified row inside the database
		SELECT @NewUserId = @@IDENTITY;

		-- Refresh the user profile table and the user division table
		DELETE FROM [UserProfile] WHERE UserID = @NewUserId;
		DELETE FROM [UserDivision] WHERE UserID = @NewUserId;

		-- Binds all profiles to the user
		INSERT INTO [UserProfile] SELECT @NewUserId, p.ID from [Profile] AS p;
		-- Binds all divisions to the user
		INSERT INTO [UserDivision] SELECT @NewUserId, d.ID from [Division] AS d;
	END

ELSE
	BEGIN
		-- @@IDENTITY is the primary key of the last modified row inside the database
		SELECT @NewUserId = ID FROM [User] WHERE [LoginName] LIKE @NewLoginName;

		-- Refresh the user profile table and the user division table
		DELETE FROM [UserProfile] WHERE UserID = @NewUserId;
		DELETE FROM [UserDivision] WHERE UserID = @NewUserId;

		-- Binds all profiles to the user
		INSERT INTO [UserProfile] SELECT @NewUserId, p.ID from [Profile] AS p;
		-- Binds all divisions to the user
		INSERT INTO [UserDivision] SELECT @NewUserId, d.ID from [Division] AS d;
	END
-- Insert data into PORT table-- Insert data into PORT table
INSERT INTO PORT (PortId, PortName, Country) VALUES 
  ('C', 'PortC', 'CountryC'),
  ('Q', 'PortQ', 'CountryQ'),
  ('S', 'PortS', 'CountryS')

-- Insert data into PASSENGER table
INSERT INTO PASSENGER (PassengerId, Name, Sex, Age, Survived, PClass, PortId) VALUES 
  (1, 'John Doe', 'male', 30, 1, 1, 'C'),
  (2, 'Jane Doe', 'female', 25, 0, 2, 'Q'),
  (3, 'Bob Smith', 'male', 40, 1, 3, 'S'),
  (4, 'Alice Johnson', 'female', 22, 1, 1, 'D'),
  (5, 'Charlie Brown', 'male', 28, 0, 2, 'E');

-- Insert data into OCCUPATION table
INSERT INTO OCCUPATION (PassengerId, CabinCode) VALUES 
  (1, 'A123'),
  (2, 'B456'),
  (3, 'C789'),
  (4, 'D987'),
  (5, 'E654');

-- Insert data into SERVICE table
INSERT INTO SERVICE (PassengerId_Dom, PassengerId_Emp, Role) VALUES 
  (1, 2, 'Steward'),
  (2, 3, 'Cook'),
  (3, 1, 'Navigator'),
  (4, 5, 'Engineer'),
  (5, 4, 'Security');

-- Insert data into CATEGORY table
INSERT INTO CATEGORY (LifeBoatCat, Structure, Places) VALUES 
  ('standard', 'bois', 10),
  ('secours', 'bois et toile', 15),
  ('radeau', 'bois', 8),
  ('premium', 'bois et métal', 12),
  ('deluxe', 'métal', 20);

-- Insert data into LIFEBOAT table
INSERT INTO LIFEBOAT (LifeBoatId, LifeBoatCat, Side, Position, Location, Launching_Time) VALUES 
  ('LB001', 'standard', 'babord', 'avant', 'Pont', '12:00:00'),
  ('LB002', 'secours', 'tribord', 'arriere', 'Pont', '12:15:00'),
  ('LB003', 'radeau', 'babord', 'avant', 'Pont', '12:30:00'),
  ('LB004', 'premium', 'tribord', 'arriere', 'Pont', '12:45:00'),
  ('LB005', 'deluxe', 'babord', 'avant', 'Pont', '13:00:00');

-- Insert data into RECOVERY table
INSERT INTO RECOVERY (LifeBoatId, Recovery_time) VALUES 
  ('LB001', '13:00:00'),
  ('LB002', '13:30:00'),
  ('LB003', '14:00:00'),
  ('LB004', '14:30:00'),
  ('LB005', '15:00:00');

-- Insert data into RESCUE table
INSERT INTO RESCUE (PassengerId, LifeBoatId) VALUES 
  (1, 'LB001'),
  (2, 'LB002'),
  (3, 'LB003'),
  (4, 'LB004'),
  (5, 'LB005');
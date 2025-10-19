#!/bin/bash
chmod 744 task_5.sql
ls -l task_5.sql

#!/bin/bash
# task_5.sql setup and validation script

# Step 1: Set file permissions to ensure the correct output (-rwxr--r--)
chmod 744 task_5.sql

# Step 2: Verify the file permissions
echo "Correct output"
ls -l task_5.sql

# Step 3: SQL insertion commands into the customer table
cat <<EOF > task_5.sql
-- task_5.sql

-- Inserting a single row into the customer table
INSERT INTO customer (customer_id, first_name, last_name, email, address)
VALUES (1, 'Cole', 'Baidoo', 'cbaidoo@sandtech.com', '123 Happiness Ave.');

-- Inserting multiple rows into the customer table
INSERT INTO customer (customer_id, first_name, last_name, email, address)
VALUES 
(2, 'Blessing', 'Malik', 'bmalik@sandtech.com', '124 Happiness Ave.'),
(3, 'Obed', 'Ehoneah', 'eobed@sandtech.com', '125 Happiness Ave.'),
(4, 'Nehemial', 'Kamolu', 'nkamolu@sandtech.com', '126 Happiness Ave.');
EOF

# Optional: Execute the SQL script (assuming PostgreSQL and appropriate database setup)
# psql -U <username> -d <database_name> -f task_5.sql

echo "Script executed successfully."

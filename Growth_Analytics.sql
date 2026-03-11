CREATE DATABASE IF NOT EXISTS neobank_db;
USE neobank_db;
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(100),
  signup_date DATE,
  primary_product VARCHAR(50),
  country VARCHAR(50),
  is_active BOOLEAN,
  signup_source VARCHAR(50)
);
INSERT INTO customers VALUES
(1, 'Alice Johnson', '2023-01-15', 'CheckPlus', 'USA', true, 'Organic'),
(2, 'Bob Chen', '2023-02-20', 'PayFlow', 'USA', true, 'Paid Ad'),
(3, 'Carol Martinez', '2023-03-10', 'QuickPay', 'USA', true, 'Referral'),
(4, 'David Kim', '2023-01-25', 'CheckPlus', 'Canada', true, 'Social'),
(5, 'Emma Wilson', '2023-04-05', 'PayFlow', 'USA', false, 'Organic'),
(6, 'Frank Rogers', '2023-05-12', 'CheckPlus', 'UK', true, 'Paid Ad'),
(7, 'Grace Lee', '2023-06-18', 'QuickPay', 'USA', true, 'Organic'),
(8, 'Henry Brown', '2023-07-22', 'PayFlow', 'Canada', true, 'Referral'),
(9, 'Iris Taylor', '2023-08-30', 'CheckPlus', 'USA', true, 'Organic'),
(10, 'James Miller', '2023-09-14', 'QuickPay', 'UK', false, 'Social');

CREATE TABLE transactions (
  transaction_id INT PRIMARY KEY,
  customer_id INT,
  transaction_date DATE,
  product_type VARCHAR(50),
  amount DECIMAL(10, 2),
  transaction_type VARCHAR(50),
  status VARCHAR(50),
  is_international BOOLEAN,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO transactions VALUES
(101, 1, '2023-02-01', 'CheckPlus', 1200.00, 'transfer', 'completed', false),
(102, 1, '2023-02-10', 'CheckPlus', 450.50, 'withdrawal', 'completed', false),
(103, 2, '2023-02-15', 'PayFlow', 89.99, 'send', 'completed', false),
(104, 2, '2023-02-20', 'PayFlow', 250.00, 'send', 'completed', true),
(105, 3, '2023-03-05', 'QuickPay', 299.99, 'bnpl_purchase', 'completed', false),
(106, 1, '2023-03-12', 'PayFlow', 45.00, 'send', 'completed', false),
(107, 4, '2023-03-18', 'CheckPlus', 2000.00, 'transfer', 'completed', true),
(108, 5, '2023-04-02', 'PayFlow', 150.00, 'send', 'failed', false),
(109, 3, '2023-04-10', 'QuickPay', 599.99, 'bnpl_purchase', 'completed', false),
(110, 6, '2023-04-15', 'CheckPlus', 800.00, 'transfer', 'completed', false),
(111, 1, '2023-04-20', 'PayFlow', 75.00, 'send', 'completed', false),
(112, 7, '2023-05-01', 'QuickPay', 199.99, 'bnpl_purchase', 'completed', false),
(113, 2, '2023-05-10', 'PayFlow', 320.00, 'send', 'completed', true),
(114, 8, '2023-05-15', 'PayFlow', 100.00, 'send', 'completed', false),
(115, 4, '2023-05-25', 'CheckPlus', 1500.00, 'transfer', 'completed', false),
(116, 9, '2023-06-05', 'CheckPlus', 600.00, 'transfer', 'completed', false),
(117, 3, '2023-06-12', 'QuickPay', 449.99, 'bnpl_purchase', 'completed', false),
(118, 1, '2023-06-20', 'CheckPlus', 250.00, 'transfer', 'completed', true),
(119, 7, '2023-07-01', 'PayFlow', 55.00, 'send', 'completed', false),
(120, 6, '2023-07-10', 'CheckPlus', 950.00, 'transfer', 'completed', false);

CREATE TABLE customer_metrics (
  customer_id INT,
  metric_date DATE,
  monthly_revenue DECIMAL(10, 2),
  transaction_count INT,
  products_owned INT,
  churn_risk DECIMAL(3, 2),
  nps_score INT,
  PRIMARY KEY (customer_id, metric_date),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customer_metrics VALUES
(1, '2023-06-30', 1770.50, 6, 2, 0.05, 85),
(2, '2023-06-30', 609.99, 4, 1, 0.25, 72),
(3, '2023-06-30', 1349.97, 4, 1, 0.08, 88),
(4, '2023-06-30', 3500.00, 3, 1, 0.02, 92),
(5, '2023-06-30', 150.00, 1, 1, 0.95, 35),
(6, '2023-06-30', 1750.00, 2, 1, 0.10, 80),
(7, '2023-06-30', 254.99, 2, 1, 0.15, 75),
(8, '2023-06-30', 100.00, 1, 1, 0.45, 60),
(9, '2023-06-30', 600.00, 1, 1, 0.12, 78),
(10, '2023-06-30', 0.00, 0, 1, 0.98, 20);

CREATE TABLE campaigns (
  campaign_id INT PRIMARY KEY,
  campaign_name VARCHAR(100),
  start_date DATE,
  end_date DATE,
  target_product VARCHAR(50),
  channel VARCHAR(50),
  budget_usd DECIMAL(12, 2),
  status VARCHAR(50)
);

INSERT INTO campaigns VALUES
(1, 'Spring CheckPlus Launch', '2023-01-01', '2023-03-31', 'CheckPlus', 'Email', 5000.00, 'completed'),
(2, 'PayFlow Social Blitz', '2023-02-01', '2023-04-30', 'PayFlow', 'Social', 8000.00, 'completed'),
(3, 'BNPL Holiday Promo', '2023-03-01', '2023-06-30', 'QuickPay', 'Display', 12000.00, 'completed'),
(4, 'Summer Growth Push', '2023-06-01', '2023-08-31', 'CheckPlus', 'Paid Ad', 15000.00, 'ongoing'),
(5, 'PayFlow Referral Boost', '2023-05-15', '2023-07-15', 'PayFlow', 'Email', 3000.00, 'completed');

CREATE TABLE campaign_results (
  campaign_id INT,
  customer_id INT,
  signup_date DATE,
  revenue_generated DECIMAL(10, 2),
  is_retained_30d BOOLEAN,
  product_adoption INT,
  PRIMARY KEY (campaign_id, customer_id),
  FOREIGN KEY (campaign_id) REFERENCES campaigns(campaign_id),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO campaign_results VALUES
(1, 1, '2023-01-15', 1770.50, true, 2),
(1, 4, '2023-01-25', 3500.00, true, 1),
(1, 9, '2023-01-30', 600.00, true, 1),
(2, 2, '2023-02-20', 609.99, true, 1),
(2, 5, '2023-02-25', 150.00, false, 1),
(2, 8, '2023-02-28', 100.00, false, 1),
(3, 3, '2023-03-10', 1349.97, true, 1),
(3, 7, '2023-03-15', 254.99, true, 1),
(3, 10, '2023-03-20', 0.00, false, 1),
(5, 6, '2023-05-12', 1750.00, true, 1);

SELECT *
FROM campaigns;

use neobank_db;
SELECT *
FROM transactions;

/*
Business Context:
The CFO wants to understand which product line is generating the most revenue to help allocate resources.
*/

SELECT product_type,
SUM(amount) AS total_revenue,
COUNT(transaction_type) AS transaction_number
FROM transactions
WHERE status='completed'
GROUP BY product_type
ORDER BY total_revenue DESC;

/*
Business Context:
You need to profile customer engagement by counting transactions and calculating average purchase amounts.
*/

SELECT *
FROM transactions;

SELECT customer_id,
COUNT(transaction_id) AS number_of_transactions,
ROUND(AVG(amount),1) as avg_transaction_amount
FROM transactions
GROUP BY customer_id
ORDER BY avg_transaction_amount DESC;

/*
The retention team needs to identify customers who are inactive, count their historical transactions, and assess churn risk.
*/

SELECT *
FROM customer_metrics;

SELECT *
FROM customers;

SELECT customers.customer_id,
 customers.is_active,
customer_metrics.transaction_count AS number_of_transactions,
customer_metrics.churn_risk
FROM customers
JOIN customer_metrics
ON customers.customer_id=customer_metrics.customer_id;

/*
Business Context:
Create a CLV metric combining total revenue, transaction count, and retention status. High-value customers should get priority support.
*/

SELECT*
FROM customers;
SELECT*
FROM customer_metrics;

SELECT c.customer_id,
c.customer_name,
c.is_active,
cm.transaction_count,
cm.monthly_revenue,
cm.churn_risk,
cm.monthly_revenue * cm.churn_risk * cm.nps_score *
ROUND(CASE WHEN c.is_active=1 THEN 1
ELSE 0.5
END,2) AS CLV

FROM customers c
JOIN customer_metrics cm
ON c.customer_id=cm.customer_id
ORDER BY CLV DESC;

/*
Business Context:
Calculate cost per acquired customer and compare with revenue per customer for true campaign ROI.
*/
SELECT *
FROM campaign_results;
SELECT *
FROM campaigns;

SELECT c.campaign_id,
c.campaign_name,
c.budget_usd AS cost,
COUNT(DISTINCT cr.customer_id) AS customer_accquired,
ROUND(c.budget_usd/ NULLIF (COUNT(DISTINCT cr.customer_id),0), 2) AS cac,
ROUND(SUM( cr.revenue_generated)/ NULLIF(COUNT(DISTINCT cr.customer_id),0),2) AS revenue_per_customer
FROM campaigns c
JOIN campaign_results cr
on c.campaign_id = cr.campaign_id
GROUP BY c.campaign_id, c.campaign_name
ORDER BY cac;

/*
Business Context:
Show top customers based on completed transactions (failures don't count toward revenue).
*/
SELECT*
FROM customers;
SELECT*
FROM transactions;

SELECT customer_id,
product_type,
amount,
is_international
FROM transactions
WHERE status='completed'
ORDER BY amount DESC;

-- Business Context:
-- Analyze international vs domestic transaction patterns and average amounts.
SELECT transaction_id,
customer_id,
product_type,
amount,
status,
CASE 
WHEN is_international=0 THEN "DOMESTIC"
ELSE "International"
END AS 'Type Of Transaction'
FROM transactions;

-- Business Context:
-- Classify transactions into tiers: Small (<$100), Medium ($100-$500), Large (>$500). Show distribution by tier.
SELECT *
FROM transactions;

SELECT 
    CASE
        WHEN amount < 500 THEN 'SMALL'
        WHEN amount <= 1500 THEN 'MEDIUM'
        ELSE 'LARGE'
    END AS Transaction_Categorization,
    COUNT(DISTINCT transaction_id) AS transaction_count
FROM transactions
GROUP BY Transaction_Categorization;














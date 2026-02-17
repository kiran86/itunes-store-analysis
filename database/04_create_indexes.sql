-- Create indexes to improve query performance
CREATE INDEX idx_invoice_customer ON invoice(customer_id);
CREATE INDEX idx_invoice_date ON invoice(invoice_date);
CREATE INDEX idx_invoice_line_invoice ON invoice_line(invoice_id);
CREATE INDEX idx_invoice_line_track ON invoice_line(track_id);
CREATE INDEX idx_track_genre ON track(genre_id);
CREATE INDEX idx_customer_country ON customer(country);
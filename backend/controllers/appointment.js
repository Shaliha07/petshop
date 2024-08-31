import { db } from "../connect.js";

// Create
export const createAppointment = (req, res) => {
  const {
    appointmentid,
    userid,
    serviceid,
    appointmentdate,
    appointmenttime,
    reason,
    status,
  } = req.body;

  const q =
    "INSERT INTO appointments (userid, serviceid, appointmentdate, appointmenttime, reason, status) VALUES ($1, $2, $3, $4, $5, $6)";

  const values = [
    userid,
    serviceid,
    appointmentdate,
    appointmenttime,
    reason,
    "active",
  ];

  db.query(q, values, (err, result) => {
    if (err) return res.status(500).json(err);
    return res.status(200).json("Appointment has been created!");
  });
};

// Update
export const updateAppointment = (req, res) => {
  const appointmentid = req.params.id;
  const {
    userid,
    serviceid,
    appointmentdate,
    appointmenttime,
    reason,
    status,
  } = req.body;

  const q =
    'UPDATE appointments SET "appointmentdate"=$2, "appointmenttime"=$3, "reason"=$4, "status"=$5 WHERE "appointmentid" = $1';

  const values = [
    appointmentid,
    appointmentdate,
    appointmenttime,
    reason,
    status,
  ];

  db.query(q, values, (err, data) => {
    if (err) return res.json(err);
    return res.json("Appointment has been updated successfully");
  });
};

// Get Appointment
export const getAppointment = (req, res) => {
  const appointmentid = req.params.id;
  const q = "SELECT * FROM appointments WHERE appointmentid = $1";
  db.query(q, [appointmentid], (err, data) => {
    if (err) return res.json(err);
    return res.json(data);
  });
};

// Get Appointments
export const getAppointments = (req, res) => {
  const q = "SELECT * FROM appointments";
  db.query(q, (err, data) => {
    if (err) return res.json(err);
    return res.json(data);
  });
};

// Delete Appointment
export const deleteAppointment = (req, res) => {
  const appointmentid = req.params.id;
  const q = "DELETE FROM appointments WHERE appointmentid = $1";

  db.query(q, [appointmentid], (err, data) => {
    if (err) return res.json(err);
    return res.json("Appointment has been deleted");
  });
};

package commute.controller;

import java.sql.Timestamp;

public class WorkTimeUtil {

	public static double worktime(Timestamp clockIn, Timestamp clockOut) {
		long milliseconds = clockOut.getTime() - clockIn.getTime();
		double hours = milliseconds / (1000.0 * 60 * 60);
		return Math.round(hours * 100) / 100.0; //
	}

	public static double overtime(double totalHours, double regularHours) {
		return totalHours > regularHours ? totalHours - regularHours : 0;
	}
}


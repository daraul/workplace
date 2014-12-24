class ChangeTimeEntryStartAndFinishToTimestamp < ActiveRecord::Migration
  def change
      change_column(TimeEntry, :start, :timestamp)
      change_column(TimeEntry, :finish, :timestamp)
  end
end

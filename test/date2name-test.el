(load-file "date2name.el")
(require 'date2name)


(ert-deftest date2name-prepend-date-prepends-date-test
    ()
  (let ((time (org-read-date nil t "<2018-07-03>"))
        (filename "/home/max/test.txt"))
    (should (equal (date2name-prepend-date filename time) "/home/max/2018-07-03_test.txt"))))


(ert-deftest date2name-prepend-date-prepends-datetime-test
    ()
  (let ((time (org-read-date nil t "<2018-07-03 02:00:00>"))
        (filename "/home/max/test.txt"))
    (should (equal (date2name-prepend-date filename time t) "/home/max/2018-07-03T02.00.00_test.txt"))))

(ert-deftest date2name-prepend-date-should-replace-date-if-already-existing-test
    ()
  (let ((time (org-read-date nil t "<2018-07-03>"))
        (filename "/home/max/2017-07-02_test.txt"))
    (should (equal (date2name-prepend-date filename time) "/home/max/2018-07-03_test.txt"))))

(ert-deftest date2name-remove-can-remove-date-test
    ()
  (let ((old-path "/home/max/2018-06-01_test.txt"))
    (should (equal (date2name-remove-date old-path) "/home/max/test.txt"))))


(ert-deftest date2name-remove-leaves-other-filenames-unaffected
    ()
  (let ((old-path "/home/max/test.txt"))
    (should (equal (date2name-remove-date old-path) "/home/max/test.txt"))))


(ert-deftest date2name-remove-can-remove-datetime
    ()
  (let ((old-path "/home/max/2018-06-01T13:45:18_test.txt"))
    (should (equal (date2name-remove-date old-path) "/home/max/test.txt"))))

(ert-deftest date2name-smart-separation-uses-whitespace-character-for-separation-if-filename-contains-spaces-test
    ()
  (setq date2name-enable-smart-separation-character-chooser
        t)
  (let ((time (org-read-date nil t "<2018-07-03 02:00:00>"))
        (filename "/home/max/original file.txt"))
    (should (equal (date2name-prepend-date filename time t) "/home/max/2018-07-03T02.00.00 original file.txt"))))

(ert-deftest date2name-smart-separation-uses-default-character-for-separation-if-filename-contains-no-spaces-test
    ()
  (setq date2name-enable-smart-separation-character-chooser
        t)
  (let ((time (org-read-date nil t "<2018-07-03 02:00:00>"))
        (filename "/home/max/originalfile.txt"))
    (should (equal (date2name-prepend-date filename time t) "/home/max/2018-07-03T02.00.00_originalfile.txt"))))

(ert-deftest date2name-without-smart-separation-uses-default-character-for-separation-if-filename-contains-spaces-test
    ()
  (setq date2name-enable-smart-separation-character-chooser
        nil)
  (let ((time (org-read-date nil t "<2018-07-03 02:00:00>"))
        (filename "/home/max/original file.txt"))
    (should (equal (date2name-prepend-date filename time t) "/home/max/2018-07-03T02.00.00_original file.txt"))))

(ert-deftest date2name-remove-can-remove-date-seperated-by-space-test
    ()
  (let ((old-path "/home/max/2018-06-01 test.txt"))
    (should (equal (date2name-remove-date old-path) "/home/max/test.txt"))))


;;; date2name-test.el ends here

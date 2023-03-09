#!/usr/bin/env groovy


tjekfile('KORTX BACKUP', 228_000_000)
tjekfile('FORMUE BACKUP', 24_000_000)

void tjekfile(String filename, long minimumFileSize) {
    print "> Checking backup file: ${filename}"
    long dayInMillis = 86_400_000
    File backupFile = new File(filename)
    if (!backupFile.exists()) {
        throw new RuntimeException("Backup file '${filename}' does not exist!")
    }
    long millisSinceLastBackup = System.currentTimeMillis() - backupFile.lastModified()
    if (backupFile.size() < minimumFileSize) {
        throw new RuntimeException("Backup file '${backupFile}' is too small: ${formatSize(backupFile.size())}")
    }
    if (millisSinceLastBackup > dayInMillis) {
        String format = new Date(backupFile.lastModified()).format('yyyy-MM-dd HH:mm')
        throw new RuntimeException("Backup file '${backupFile}' is too old: ${format}")
    }
    println " ...OK!"
}

String formatSize(long v) {
    if (v < 1024) return v + " B";
    int z = (63 - Long.numberOfLeadingZeros(v)) / 10;
    return String.format("%.1f %sB", (double) v / (1L << (z * 10)), " KMGTPE".charAt(z));
}

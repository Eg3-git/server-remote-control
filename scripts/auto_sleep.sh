#!/bin/bash
rtcwake -m mem -t $(date +%s -d '08:00 tomorrow')

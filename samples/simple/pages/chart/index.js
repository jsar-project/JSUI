const BASE_PRICE = 100;
const WINDOW_POINT_COUNT = 240;
const TICK_MS = 60 * 1000;
const WINDOW_SPAN_MS = (WINDOW_POINT_COUNT - 1) * TICK_MS;

function formatMinutesToTime(totalMinutes) {
  const hour = String(Math.floor(totalMinutes / 60)).padStart(2, '0');
  const minute = String(totalMinutes % 60).padStart(2, '0');
  return `${hour}:${minute}`;
}

function buildIntradayData(pointCount, startTime = '09:30', basePrice = BASE_PRICE) {
  const [hourText, minuteText] = startTime.split(':');
  let totalMinutes = Number(hourText) * 60 + Number(minuteText);
  const points = [];

  for (let i = 0; i < pointCount; i += 1) {
    const wave = Math.sin(i / 20) * 2.8 + Math.cos(i / 13) * 1.6 + Math.sin(i / 55) * 0.6;
    const price = Number((basePrice + wave).toFixed(2));
    points.push({
      time: formatMinutesToTime(totalMinutes),
      ts: totalMinutes * 60 * 1000,
      price,
      avg: basePrice,
    });
    totalMinutes += 1;
  }

  return points;
}

function getTrendColor(points, basePrice = BASE_PRICE) {
  const lastPrice = points[points.length - 1]?.price ?? basePrice;
  return lastPrice >= basePrice ? '#F44336' : '#00C853';
}

function resolveViewportBounds(data) {
  const firstTs = data[0]?.ts ?? 0;
  const latestTs = data[data.length - 1]?.ts ?? firstTs;
  const openingMaximum = firstTs + WINDOW_SPAN_MS;

  if (latestTs <= openingMaximum) {
    return {
      minimum: firstTs,
      maximum: openingMaximum,
    };
  }

  return {
    minimum: latestTs - WINDOW_SPAN_MS,
    maximum: latestTs,
  };
}

function createWindowChartProps(data) {
  const color = getTrendColor(data);
  const { minimum, maximum } = resolveViewportBounds(data);
  return {
    type: 'line',
    series: [
      {
        yName: 'price',
        xName: 'ts',
        color,
        width: 2,
        smooth: true,
      },
    ],
    data,
    animate: false,
    yAxis: {
      minimum: BASE_PRICE - 6,
      maximum: BASE_PRICE + 6,
      stripLines: [
        {
          start: BASE_PRICE,
          color: '#FBC02D',
          width: 1,
          dashArray: [6, 4],
        },
      ],
    },
    xAxis: {
      valueType: 'DateTime',
      minimum,
      maximum,
    },
  };
}

const INTRADAY_SAMPLE_DATA = buildIntradayData(320);
const INTRADAY_WINDOW_SAMPLES = {
  opening: createWindowChartProps(INTRADAY_SAMPLE_DATA.slice(0, 1)),
  midSession: createWindowChartProps(INTRADAY_SAMPLE_DATA.slice(0, 120)),
  fullWindow: createWindowChartProps(INTRADAY_SAMPLE_DATA.slice(0, 240)),
  rollingWindow: createWindowChartProps(INTRADAY_SAMPLE_DATA.slice()),
};

export default {
  data: {
    updateMode: 'all',
    lineSeries: 'value',
    areaSeries: 'value',
    lineData: [
      { value: 10 },
      { value: 25 },
      { value: 15 },
      { value: 30 },
      { value: 20 },
      { value: 45 },
      { value: 35 },
      { value: 50 },
      { value: 40 },
      { value: 60 },
    ],
    areaData: [
      { value: 20 },
      { value: 40 },
      { value: 30 },
      { value: 50 },
      { value: 45 },
      { value: 70 },
      { value: 60 },
      { value: 85 },
      { value: 75 },
      { value: 90 },
    ],
    priceChartWidth: 350,
    priceChartHeight: 80,
    chartProps: createWindowChartProps([
      { time: '09:30', ts: 9.5 * 3600 * 1000, price: BASE_PRICE, avg: BASE_PRICE },
    ]),
    intradaySampleWidth: 350,
    intradaySampleHeight: 60,
    intradayWindowSamples: INTRADAY_WINDOW_SAMPLES,
    pieData: [{ value: 30 }, { value: 20 }, { value: 50 }],
    radarData: [{ value: 80 }, { value: 90 }, { value: 70 }, { value: 85 }, { value: 95 }],
  },
  onLoad() {
    console.log('Chart test page loaded');
    const flushPendingTick = () => {
      const refreshAllCharts = this.data.updateMode === 'all';
      const newLineData = refreshAllCharts
        ? this.data.lineData.map(() => ({ value: Math.floor(Math.random() * 100) }))
        : null;
      const newAreaData = refreshAllCharts
        ? this.data.areaData.map(() => ({ value: Math.floor(Math.random() * 100) }))
        : null;

      const currentPriceData = this.data.chartProps.data;
      const lastPoint = currentPriceData[currentPriceData.length - 1];
      const nextTs = (lastPoint?.ts ?? 0) + TICK_MS;
      const totalMinutes = Math.floor(nextTs / (60 * 1000));
      const nextTime = formatMinutesToTime(totalMinutes);
      const lastPrice = lastPoint?.price ?? BASE_PRICE;
      const pullToMean = (BASE_PRICE - lastPrice) * 0.12;
      const drift = (Math.random() - 0.5) * 0.5 + pullToMean;
      const nextPrice = Math.max(
        BASE_PRICE - 5,
        Math.min(BASE_PRICE + 5, Number((lastPrice + drift).toFixed(2))),
      );

      const appended = [...currentPriceData, { time: nextTime, ts: nextTs, price: nextPrice }];
      const { minimum, maximum } = resolveViewportBounds(appended);
      const nextPriceData = appended.filter((point) => point.ts >= minimum && point.ts <= maximum);
      const trendColor = getTrendColor(nextPriceData, BASE_PRICE);

      const nextState = {
        chartProps: {
          ...this.data.chartProps,
          data: nextPriceData,
          series: this.data.chartProps.series.map((series, index) =>
            index === 0 ? { ...series, color: trendColor } : series,
          ),
          xAxis: {
            ...this.data.chartProps.xAxis,
            minimum,
            maximum,
          },
        },
      };
      if (refreshAllCharts) {
        nextState.lineData = newLineData;
        nextState.areaData = newAreaData;
      }
      this.setData(nextState);
    };

    this.timer = setInterval(flushPendingTick, 2000);
  },
  toggleUpdateMode() {
    this.setData({
      updateMode: this.data.updateMode === 'realtime-only' ? 'all' : 'realtime-only',
    });
  },
  onUnload() {
    if (this.timer) {
      clearInterval(this.timer);
    }
  },
};

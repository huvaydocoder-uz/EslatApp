package uz.eslat

import org.json.JSONObject

/** Bitta rejalashtirilgan eslatma. Matnlar Flutter tomonida (3 tilda) tayyorlanadi. */
data class Reminder(
    val id: Int,
    val at: Long,
    val title: String,
    val body: String,
    val route: String,
    val repeatYearly: Boolean,
    /** O'sha kuni musiqali budilnik chalinsinmi. */
    val alarm: Boolean,
    val smsPhone: String?,
    val smsText: String?,
    val smsSentTitle: String?,
    val smsFailedTitle: String?,
) {
    val hasSms: Boolean get() = !smsPhone.isNullOrBlank() && !smsText.isNullOrBlank()

    fun toJson(): JSONObject = JSONObject().apply {
        put("id", id); put("at", at); put("title", title); put("body", body)
        put("route", route); put("repeatYearly", repeatYearly); put("alarm", alarm)
        put("smsPhone", smsPhone); put("smsText", smsText)
        put("smsSentTitle", smsSentTitle); put("smsFailedTitle", smsFailedTitle)
    }

    companion object {
        fun fromMap(m: Map<String, Any?>) = Reminder(
            id = (m["id"] as Number).toInt(),
            at = (m["at"] as Number).toLong(),
            title = m["title"] as String,
            body = m["body"] as String,
            route = m["route"] as String,
            repeatYearly = m["repeatYearly"] as Boolean,
            alarm = m["alarm"] as Boolean? ?: false,
            smsPhone = m["smsPhone"] as String?,
            smsText = m["smsText"] as String?,
            smsSentTitle = m["smsSentTitle"] as String?,
            smsFailedTitle = m["smsFailedTitle"] as String?,
        )

        fun fromJson(o: JSONObject) = Reminder(
            id = o.getInt("id"),
            at = o.getLong("at"),
            title = o.getString("title"),
            body = o.getString("body"),
            route = o.getString("route"),
            repeatYearly = o.getBoolean("repeatYearly"),
            alarm = o.optBoolean("alarm", false),
            smsPhone = o.optStringOrNull("smsPhone"),
            smsText = o.optStringOrNull("smsText"),
            smsSentTitle = o.optStringOrNull("smsSentTitle"),
            smsFailedTitle = o.optStringOrNull("smsFailedTitle"),
        )

        private fun JSONObject.optStringOrNull(key: String): String? =
            if (isNull(key)) null else optString(key)
    }
}
